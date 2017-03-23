From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Mar 2017 17:52:47 +0800
Subject: [RESEND PATCH v4 2/9] iio: adc: add support for X-Powers AXP20X
 and AXP22X PMICs ADCs
In-Reply-To: <20170323093527.ojcdpvruzqnhvysq@earth>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-3-quentin.schulz@free-electrons.com>
 <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
 <20170323093527.ojcdpvruzqnhvysq@earth>
Message-ID: <CAGb2v655AfEavMqVV-XTyYzHWt5qFsMnoMsTVd8HRDkCgjiTeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 5:35 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Mar 22, 2017 at 12:34:45PM +0800, Chen-Yu Tsai wrote:
>> P.S. I'm thinking about having MFD_AXP20X imply its various sub-drivers.
>> Not sure if that was the intended usage of the new imply syntax though.
>
> I think adding "default MFD_AXP20X" to the sub-drivers is cleaner,
> as you will not end up with a long list.

I'd still need to add imply statements for the various subsystems though,
like regulators, power supplies, extcon, etc..
But I suppose that's cleaner, and fits the original intent of the syntax.

ChenYu
