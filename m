From: bleung@chromium.org (Benson Leung)
Date: Fri, 8 May 2015 13:42:09 -0700
Subject: [PATCH v8 6/9] mailbox: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <1430761002-9327-7-git-send-email-abrestic@chromium.org>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-7-git-send-email-abrestic@chromium.org>
Message-ID: <CANLzEksWtzSmz=OCuwVdY5RSG6gDrOoMyGsW3i9jMcjD3WtPKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 4, 2015 at 10:36 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> + - compatible: For Tegra124, must contain "nvidia,tegra124-xusb-mbox".
> +   Otherwise, must contain '"nvidia,<chip>-xusb-mbox",
> +   "nvidia,tegra124-xusb-mbox"' where <chip> is tegra132.


The driver doesn't seem to have any particular entry for tegra132, so
that would be a bad example.

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung at chromium.org
