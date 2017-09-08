From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 8 Sep 2017 16:03:21 +0100
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH_v6_4=2F7=5D_arm64=3A_kvm=3A_support_user_?=
 =?UTF-8?Q?space_to_query_RAS_extension_feature?=
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015F5A1C@DGGEMA503-MBX.china.huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-5-git-send-email-gengdongjiu@huawei.com>
 <59A84F9D.8030309@arm.com> <29951852-8d91-7c33-c68b-ad8b4bbdea54@huawei.com>
 <59B1747A.5030909@arm.com>
 <0184EA26B2509940AA629AE1405DD7F2015F5A1C@DGGEMA503-MBX.china.huawei.com>
Message-ID: <CAFEAcA8tXV31RTa+RCkkNFyR2t1dTwR5kYXUmBXMj9wkeLWCpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2017 at 15:34, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi Peter/ shenglong,
>    What is your idea about it? We may need to consult with you about it.

I agree with what I take to be James' general point that we
should be careful to distinguish "KVM supports API A to
do a particular operation on the guest" and "KVM supports API
B to tell QEMU about certain events" and so on, and not just
lump these all together under "host CPU supports RAS and
so we turn all these on together and expose RAS to the guest
regardless". I don't know enough about the details of RAS
to be more specific than that general point of view.

PS: your mail client doesn't seem to be doing the right
thing with wrapping long lines :-(

thanks
-- PMM
