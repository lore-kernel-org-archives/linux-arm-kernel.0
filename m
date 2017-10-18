From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 18 Oct 2017 20:27:00 +0800
Subject: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
In-Reply-To: <20171018101722.kce2tcvpd7xdpo46@pd.tnic>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <20171017164336.cedso3f35lpeam7f@pd.tnic>
 <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
 <20171018101722.kce2tcvpd7xdpo46@pd.tnic>
Message-ID: <577d79ad-9357-ea40-63eb-1d2988642710@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/10/18 18:17, Borislav Petkov wrote:
> On Wed, Oct 18, 2017 at 11:04:28AM +0800, gengdongjiu wrote:
>> ARM does not have ACPI_HEST_NOTIFY_NMI notification, which should only
>> used by x86. In the code, I see those guards are never used.
> Yeah, I see it now.

Borislav/Rafael,
  For this patch(the first one), whether it can be firstly applied?
This patch is code clean and not related with the second one.
For the second, I may discuss more with James.
Thanks so much in advance.

> 
> Thx.
> 
> -- 
