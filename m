From: peter@hurleysoftware.com (Peter Hurley)
Date: Mon, 4 Apr 2016 14:07:37 -0700
Subject: [PATCH v7 1/5] of/serial: move earlycon early_param handling to
 serial
In-Reply-To: <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <5702D799.5050101@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 06:40 AM, Aleksey Makarov wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
> 
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to defer setting up DT console until ACPI/DT decision is made.
> 
> Rename the exported function to avoid clashing with the function from
> arch/microblaze/kernel/prom.c

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
