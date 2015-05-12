From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 12 May 2015 07:00:41 +0200
Subject: [PATCH] ARM: mvebu: add "nor-jedec" flash compatible binding
In-Reply-To: <5550A92A.2040408@free-electrons.com>
References: <1431066023-19479-1-git-send-email-zajec5@gmail.com>
 <5550A92A.2040408@free-electrons.com>
Message-ID: <CACna6rz9cisJt492kPyzX2nbvsSCig-ubhr6eGAxnxHzUNTvag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2015 at 15:05, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> On 08/05/2015 08:20, Rafa? Mi?ecki wrote:
>> Starting with commits
>> 8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
>> 1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
>> we have "nor-jedec" binding indicating support for JEDEC identification.
>
> did you actually check that all the NOR flash referenced in the dts supports
> the JEDEC identification?

Yes, I did, yes, they do.


> If it is the case I will add it in mvebu/dt soon.

Please drop this patch as there is a discussion (in tegra patch) about
renaming the binding to "jedec,spi-nor".
