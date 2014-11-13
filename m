From: broonie@kernel.org (Mark Brown)
Date: Thu, 13 Nov 2014 10:50:32 +0000
Subject: [PATCH 2/4 V2] ASoC: Samsung: Add arndale_rt5631 machine driver
In-Reply-To: <A1C3160B59C9424AB8F073F7A67DB325@sisodomain.com>
References: <1415781339-16089-1-git-send-email-krishna.md@samsung.com>
 <1415781339-16089-3-git-send-email-krishna.md@samsung.com>
 <20141112222902.GV3815@sirena.org.uk>
 <A1C3160B59C9424AB8F073F7A67DB325@sisodomain.com>
Message-ID: <20141113105032.GD3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 03:45:57PM +0530, D Krishna Mohan wrote:

> From the rest of the comment what I understand is you want me to change the
> names of struct snd_soc_dai_link and struct snd_soc_card.
> Am that right? and/or do you want me to change the names whereever it sounds
> like generic and make it specific for arndale - rt5631 pair?

The latter, but just the former might be OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/cbf7d047/attachment-0001.sig>
