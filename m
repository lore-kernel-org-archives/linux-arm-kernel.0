From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 01 Apr 2017 13:20:11 -0700
Subject: [PATCH V4 2/2] thermal: broadcom: add Northstar thermal driver
In-Reply-To: <20170401195443.GE28514@localhost.localdomain>
References: <20170331073132.21457-2-zajec5@gmail.com>
 <20170331201124.656-1-zajec5@gmail.com>
 <20170331201124.656-2-zajec5@gmail.com>
 <20170401195443.GE28514@localhost.localdomain>
Message-ID: <DC208578-DA81-4113-B073-64AA920F7FFA@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On April 1, 2017 12:54:45 PM PDT, Eduardo Valentin <edubezval@gmail.com> wrote:
>Also, I have just merged a BRCM driver. Does it make sense to move it
>here too?

I think it does make sense to have all Broadcom SoCs thermal drivers under a broadcom/ directory. As a matter of fact, I will be submitting another one (for brcmstb SoCs) shortly.
Hi Eduardo,
-- 
Florian
