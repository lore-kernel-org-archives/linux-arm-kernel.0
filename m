From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 24 Jun 2015 15:14:32 +0530
Subject: [RFC PATCH v6 2/2] nvmem: Add Vybrid OCOTP and OCROM support
In-Reply-To: <558A7A67.806@linaro.org>
References: <cover.1435066190.git.maitysanchayan@gmail.com>
 <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
 <1037424954.250728.1435087901102.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <20150624051903.GA11753@Sanchayan-Arch.toradex.int>
 <558A7A67.806@linaro.org>
Message-ID: <20150624094432.GD11753@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-06-24 10:37:43, Srinivas Kandagatla wrote:
> 
> 
> On 24/06/15 06:19, maitysanchayan at gmail.com wrote:
> >I just tested it without the "select REGMAP_MMIO" and it works just fine.
> You just got lucky in this case, as REGMAP_MMIO is getting selected
> somewhere else.
> 
> Drivers should directly select the dependecies. In this case this driver
> actually is going to use REGMAP_MMIO, so keeping it selected is the right
> thing.

Yes, you are right. Checking the .config file shows that this is enabled even
with the explicit selection removed in my driver's kconfig.

Sorry about missing that Stefan and Srinivas.

- Sanchayan.
