From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 21:20:31 +0100
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <CAJAp7OiVwvPjRbrBxw7Dndvk4Apwz_bx=CzSqeqd3JzYhmB7Kw@mail.gmail.com>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <7DA73171-01A5-4158-9A69-015B62D2D7E8@codeaurora.org>
 <CAJAp7OiVwvPjRbrBxw7Dndvk4Apwz_bx=CzSqeqd3JzYhmB7Kw@mail.gmail.com>
Message-ID: <2155628.BceQuZbXC8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 08:33:04 Bjorn Andersson wrote:
> 
> But are these values actually used by the boot loader?
> 
> As far as I could see in 8974 the dtbTool provided by Qualcomm
> extracts the values from the list of dtbs and use them to create the
> table-of-content in the QCDT blob. The boot loader then looks in this
> TOC to pick the right dtb to use.
> 

I guess if I understand this right, we just need to fix that dtbTool
then to look at the top-level compatible property and/or machine
name instead?

	Arnd
