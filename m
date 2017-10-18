From: bp@suse.de (Borislav Petkov)
Date: Wed, 18 Oct 2017 12:17:39 +0200
Subject: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
In-Reply-To: <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <20171017164336.cedso3f35lpeam7f@pd.tnic>
 <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
Message-ID: <20171018101722.kce2tcvpd7xdpo46@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 11:04:28AM +0800, gengdongjiu wrote:
> ARM does not have ACPI_HEST_NOTIFY_NMI notification, which should only
> used by x86. In the code, I see those guards are never used.

Yeah, I see it now.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
