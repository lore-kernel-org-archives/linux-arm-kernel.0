From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Apr 2013 14:06:10 +0100
Subject: [PATCH v5 3/6] gpio: samsung: Skip legacy GPIO registration if
 pinctrl-s3c64xx is present
In-Reply-To: <22399020.Z89v9QS8su@flatron>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-4-git-send-email-tomasz.figa@gmail.com>
 <20130416162750.GO26958@opensource.wolfsonmicro.com>
 <22399020.Z89v9QS8su@flatron>
Message-ID: <20130417130609.GA13687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 12:35:58AM +0200, Tomasz Figa wrote:
> On Tuesday 16 of April 2013 17:27:50 Mark Brown wrote:

> > Strictly speaking this is a separate bug fix (though I see that's
> > already in -next separately anyway so whatever).

> Right. But this fix is so small that I thought it would be a major waste 
> of mail server processing power to send it as a separate patch.

There's reviewer bandwidth too - one of the things people check for is
that the change is doing what it's supposed to do, extra stuff in there
is usually a red flag.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130417/67479e82/attachment.sig>
