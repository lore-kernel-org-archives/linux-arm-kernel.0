From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 16 Oct 2017 21:59:01 +0200
Subject: [PATCH] arm64: KVM: set right LR register value for 32 bit guest
 when inject abort
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201699F61@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F201699F61@DGGEMA503-MBX.china.huawei.com>
Message-ID: <20171016195901.GA5753@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 04:10:01PM +0000, gengdongjiu wrote:
> Hi Marc,
> 
> > 
> > Please also update the 32bit code accordingly, as it looks broken too.
> 
> I have updated the 32 bit code according, in my hand, there is no arm32 host environment,
> So there is no method to verify it in the arm32 host, only verify the patch in the arm64 host.
> 
> Anyway I firstly send the patch out for review. Thanks.
> 
In this case, if you just clearly specify in the patches you send out
that the 32-bit one is untested, you can ask someone to test it for you.

Thanks,
-Christoffer
