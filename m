From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Apr 2018 12:17:33 +0100
Subject: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
In-Reply-To: <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
Message-ID: <20180417111733.GG8973@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:

> I guess the blocking patch in this patchset is the patch "add IEC958 
> channel status control helper". This patch has been reviewed several 
> times, but did not get a ack so far.
> If you think these helpers will not be merged, I will reintegrate the 
> corresponding code in stm driver.
> Please let me know, if I need to prepare a v2 without helpers, or if we 
> can go further in the review of iec helpers patch ?

I don't mind either way but you're right here, I'm waiting for Takashi
to review the first patch.  I'd probably be OK with it just integrated
into the driver if we have to go that way though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/17ffbb43/attachment.sig>
