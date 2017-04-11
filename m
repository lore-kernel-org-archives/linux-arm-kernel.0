From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Apr 2017 17:30:04 +0100
Subject: [RFC PATCH 0/7] Cavium CN99xx SMMUv3 Errata workarounds
In-Reply-To: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Message-ID: <20170411163004.GH17109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 08:12:38PM +0530, linucherian at gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium CN99xx SMMUv3 implementation has two Silicon Erratas.
> 1. Errata ID #74
>    SMMU register alias Page 1 is not implemented
> 2. Errata ID #126
>    SMMU doesnt support unique IRQ lines for gerror, eventq and cmdq-sync

Is this device in production, or just part of a test chip?

Will
