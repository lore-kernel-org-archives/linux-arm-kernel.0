From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Nov 2013 12:51:21 +0000
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized
 using pinfunc.
In-Reply-To: <528BFD28.3050909@wwwdotorg.org>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <528BB1F2.4080107@wwwdotorg.org>
 <CAD=FV=XS0dbE7zfgDGVdp84h4fHH6tfO8aN_HNh1LbOjYy51aQ@mail.gmail.com>
 <528BB913.6080409@wwwdotorg.org>
 <CAH9JG2UjnL5bZzNUuJhWY3GpwPD=rJvR2O4Hcpm33G+prSS=BA@mail.gmail.com>
 <528BFD28.3050909@wwwdotorg.org>
Message-ID: <20131120125121.GB2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 05:07:04PM -0700, Stephen Warren wrote:
> On 11/19/2013 05:02 PM, Kyungmin Park wrote:

> > Some pins are not connected (NC). At that cases, there's no drivers to
> > handle it. To reduce power leakage, it sets proper configuration with
> > values instead of reset values.

> Hmm. Shouldn't board firmware configure that kind of thing?

> (Of course, some firmware is starting to use DT to configure itself, so
> that just shifts the DT discussion, but anyway).

Even if it's not sometimes the firmware is intended to be thin with
configuration punted to the OS.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/a7609748/attachment.sig>
