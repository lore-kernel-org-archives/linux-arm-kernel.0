From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 28 Oct 2015 09:27:48 +0530
Subject: [PATCH v3 05/12] doc/bindings: Update Layerscape PCIe devicetree
 binding to be more flexible
In-Reply-To: <BY1PR0301MB13039481CB958A3323FB03B2823E0@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
 <1444891672-32117-6-git-send-email-bhupesh.sharma@freescale.com>
 <5383901.aC2HYopUNW@wuerfel>
 <BY1PR0301MB13039481CB958A3323FB03B2823E0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <CAHM4w1=-qF_JL-PbyNerzRrAVfapswmaZkcqQWeoMxWbV=ghKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,


On Fri, Oct 16, 2015 at 1:41 AM, Sharma Bhupesh
<bhupesh.sharma@freescale.com> wrote:
> I think this can be moved to the generic bindings for DWC3 PCIe driver. However
> I cannot vouch if the same is true for usage of this IP in other SoCs and it
> will not break existing drivers if this property is not defined in their SoC DTSI.
>
> So adding a few old ST colleagues (Pratyush, Gabriel, Fabrice), who I am sure have used this IP in ST SoCs
> for their comments as well.

Sorry for delayed response. Was on leave and away from internet.

>
> So the question would be - do you think it will be ok to make the clock related
> properties optional in 'designware-pcie.txt' rather than required.

I think they should have been optional.

~Pratyush
