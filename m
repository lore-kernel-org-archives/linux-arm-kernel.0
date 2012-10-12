From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 12 Oct 2012 20:22:52 +0530
Subject: [PATCH V2 3/3] ARM: SPEAr13xx: Pass DW DMAC platform data from DT
In-Reply-To: <20121012144837.GE12801@game.jcrosoft.org>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <2039bc164224b0068bc078b6cd8df6218e754fce.1350051925.git.viresh.kumar@linaro.org>
 <20121012144837.GE12801@game.jcrosoft.org>
Message-ID: <CAKohpo=vMchmiz70evBB5bPqt4O4DWUocd5M1o9gc8fsY_Fkiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2012 20:18, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
>>  static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
>> -     OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_dma_priv),
>> -     OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
>> -     OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
>> +     OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, "cf"),
> ?/

Sorry. can't get it :(
