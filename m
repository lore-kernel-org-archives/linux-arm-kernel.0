From: dann.frazier@canonical.com (dann frazier)
Date: Tue, 28 Feb 2017 13:19:19 -0700
Subject: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
In-Reply-To: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
References: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
Message-ID: <CALdTtnsbh3fZF+Ci1JmQ=Awod5QPWB4+gTRWx0u9=xyaLfhNmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 8:24 PM, Timur Tabi <timur@codeaurora.org> wrote:
> For Qualcomm Technologies QDF2400 SOCs that are affected by
> erratum E44, the ACPI oem_revision field is actually set to 1,
> not 0.

Should this 'Fixes: d8a4995bcea1 ("PCI: Add ACS quirk for Qualcomm
QDF2400 and QDF2432")' ?

  -dann
