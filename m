From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Wed, 20 Dec 2017 17:42:58 +0530
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <20171220114924.GA5377@afzalpc>
References: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
 <20171219112954.GA14910@afzalpc>
 <4e80e47a-d7b4-c09c-fe88-a7dff6522038@arm.com>
 <20171220045219.GA6416@afzalpc>
 <b0e23a0b-8488-b1bc-8afe-cd68e47b9ad6@arm.com>
 <20171220114924.GA5377@afzalpc>
Message-ID: <20171220121258.GA6078@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 20, 2017 at 05:19:24PM +0530, afzal mohammed wrote:

> Cortex-R, as security extension is a requisite for this feature, which
> Cortex-R don't have on ARMv7.

Okay seems even ARMv8-R doesn't have security extensions, only ARMv8-M
has it as compared to ARMv7's.

afzal
