From: lho@apm.com (Loc Ho)
Date: Mon, 25 Jan 2016 13:23:44 -0800
Subject: [PATCH v4 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <1453335459-3617-2-git-send-email-lho@apm.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
 <1453335459-3617-2-git-send-email-lho@apm.com>
Message-ID: <CAPw-ZTnm5F3Kt+_J6HoNCYbx8R7JVkME5yA9V-hAwRtr8ge9ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 20, 2016 at 4:17 PM, Loc Ho <lho@apm.com> wrote:
>
> The function acpi_gsi_to_irq must return 0 on success as the caller
> ghes_probe expects an 0 for success. This change also matches x86
> implementation.
>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>


Any issue with this version? If not, can this be pulled into 4.5?

-Loc
