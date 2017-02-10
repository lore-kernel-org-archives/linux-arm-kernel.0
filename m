From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Feb 2017 12:01:32 +0000
Subject: [PATCH v4 4/8] ASoC: sun8i-codec-analog: Add amplifier event to
 fix first delay
In-Reply-To: <CAGb2v66NXJ5RG8VUbvtZcqXzzOvhRc8A_M1R=2rRpfnHNbZDpw@mail.gmail.com>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
 <20170202092422.5588-5-mylene.josserand@free-electrons.com>
 <CAGb2v66NXJ5RG8VUbvtZcqXzzOvhRc8A_M1R=2rRpfnHNbZDpw@mail.gmail.com>
Message-ID: <20170210120132.4w6rv6fagnebfben@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 02:08:54PM +0800, Chen-Yu Tsai wrote:

> One solution that might work is to mute the headphone output
> while the amp is being charged, by setting SUN8I_ADDA_HP_VOLC_HP_VOL
> to 0, and then restoring the value once it is charged. In other
> words, overriding the value for the duration of sun8i_headphone_amp_event.

This sounds like you want to make it an _AUTODISABLE control.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/313d51ba/attachment.sig>
