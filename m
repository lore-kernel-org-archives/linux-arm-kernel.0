From: joelf@ti.com (Joel Fernandes)
Date: Thu, 10 Oct 2013 10:53:32 -0500
Subject: [PATCH V6 02/15] ARM: OMAP2+: AM33XX: add lateinit hook for
 calling pm late init
In-Reply-To: <CAGo_u6r-tfnWFP_FNAm5PdWctuPVvh8-XXDscCw+zKHj0FRM_A@mail.gmail.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361098-8283-1-git-send-email-nm@ti.com> <52563BD8.1060703@ti.com>
 <20131010133209.GA13105@kahuna> <5256C5D2.9030302@ti.com>
 <5256C686.6000301@ti.com>
 <CAGo_u6r-tfnWFP_FNAm5PdWctuPVvh8-XXDscCw+zKHj0FRM_A@mail.gmail.com>
Message-ID: <5256CD7C.5080909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2013 10:45 AM, Nishanth Menon wrote:
> On Thu, Oct 10, 2013 at 10:23 AM, Joel Fernandes <joelf@ti.com> wrote:
>> I see a function of that name already exists. I guess you can leave your patch
>> as is then and not have to do this.
> 
> 
> Can I consider that as an Acked-by :) ?

Yes, sure, for this particular patch:

Acked-by: Joel Fernandes <joelf@ti.com>

thanks,

-Joel
