From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 16 Jul 2014 15:17:13 -0700
Subject: [PATCH v4 3/3] regulator: qcom-rpm: Regulator driver for the
 Qualcomm RPM
In-Reply-To: <CAMf-jSn2YHF7ihRpXMfkPWYt8pNCj4o395OGha3BHD3K3mUv9g@mail.gmail.com>
References: <1405465241-28684-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1405465241-28684-4-git-send-email-bjorn.andersson@sonymobile.com>
 <CAMf-jSn2YHF7ihRpXMfkPWYt8pNCj4o395OGha3BHD3K3mUv9g@mail.gmail.com>
Message-ID: <CAJAp7Oj1R-EkJoSdLEa6SBLbzE_N1MjsystQ9Z+x4L_SjU=56w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 12:01 AM, pramod gurav
<pramod.gurav.etc@gmail.com> wrote:
> Hi Bjorn,
>
> On Wed, Jul 16, 2014 at 4:30 AM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
[...]
>> +static const struct regulator_linear_range pldo_ranges[] = {
>> +       REGULATOR_LINEAR_RANGE( 750000,   0,  59, 12500),
>
> ERROR: space prohibited after that open parenthesis '('
>

I prefer the nicely aligned columns over checkpatch correctness here.

>> +       REGULATOR_LINEAR_RANGE(1500000,  60, 123, 25000),
>> +       REGULATOR_LINEAR_RANGE(3100000, 124, 160, 50000),
>> +};
>> +

Regards,
Bjorn
