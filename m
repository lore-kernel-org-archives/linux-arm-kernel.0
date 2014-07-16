From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Jul 2014 23:28:29 +0100
Subject: [PATCH v4 3/3] regulator: qcom-rpm: Regulator driver for the
 Qualcomm RPM
In-Reply-To: <CAJAp7Oj1R-EkJoSdLEa6SBLbzE_N1MjsystQ9Z+x4L_SjU=56w@mail.gmail.com>
References: <1405465241-28684-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1405465241-28684-4-git-send-email-bjorn.andersson@sonymobile.com>
 <CAMf-jSn2YHF7ihRpXMfkPWYt8pNCj4o395OGha3BHD3K3mUv9g@mail.gmail.com>
 <CAJAp7Oj1R-EkJoSdLEa6SBLbzE_N1MjsystQ9Z+x4L_SjU=56w@mail.gmail.com>
Message-ID: <20140716222829.GO17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 03:17:13PM -0700, Bjorn Andersson wrote:
> On Wed, Jul 16, 2014 at 12:01 AM, pramod gurav
> > On Wed, Jul 16, 2014 at 4:30 AM, Bjorn Andersson
> > <bjorn.andersson@sonymobile.com> wrote:

> >> +static const struct regulator_linear_range pldo_ranges[] = {
> >> +       REGULATOR_LINEAR_RANGE( 750000,   0,  59, 12500),

> > ERROR: space prohibited after that open parenthesis '('

> I prefer the nicely aligned columns over checkpatch correctness here.

Me too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/93638325/attachment.sig>
