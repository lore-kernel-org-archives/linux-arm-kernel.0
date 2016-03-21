From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 08:27:03 +0100
Subject: [PATCH v3 1/5] dmaengine: sun6i: Simplify and fix lli setting
In-Reply-To: <2654a93049f1c7a459e7fb5a4ac112e9d2d30787.1458311540.git.moinejf@free.fr>
References: <cover.1458311540.git.moinejf@free.fr>
 <2654a93049f1c7a459e7fb5a4ac112e9d2d30787.1458311540.git.moinejf@free.fr>
Message-ID: <20160321072703.GU30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 12:50:07PM +0100, Jean-Francois Moine wrote:
> Checking the DMA config before setting the lli list avoids to do tests
> inside the setting loop.
> Also, in case of audio streaming, the sound PCM DMA engine sets only
> the burst and bus width of the device. Set the lacking memory values
> to system values while checking the config.

You're doing two separate and unrelated things here, please make two
patches.

Also, you commit title says you fix something, but you never say what
the issue actually is in the commit log.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/d45b98a5/attachment.sig>
