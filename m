From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 5 Dec 2017 23:05:52 +0100
Subject: [PATCH V6 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
In-Reply-To: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAJZ5v0gq-Xv1V90GEcfxdnrADQn2Gern=LBnsbSzmrU9M0+FEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 6:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Introduce new ACPI and OF device ids for thw HW along with the helper
> functions.
>
> Changes from v5:
> * use struct device as a calling parameter to get_match_data() callback
> so that we can reuse the existing OF API.
> * revert the change on acpi_get_match_data() to V4.
>
> Sinan Kaya (7):
>   Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
>   ACPI / bus: Introduce acpi_get_match_data() function
>   device property: Introduce a common API to fetch device match data
>   OF: properties: Implement get_match_data() callback
>   ACPI: properties: Implement get_match_data() callback
>   dmaengine: qcom_hidma: Add support for the new revision
>   dmaengine: qcom_hidma: Add identity register support

Sakari, can you please have a look at this series?

I'm particularly interested in your opinion on patches [2-3/7] and [5/7].

Thanks,
Rafael
