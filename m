From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 16 Feb 2016 20:20:32 +0100
Subject: [PATCH v6 1/2] ACPI: introduce a function to find the first
 physical device
In-Reply-To: <1455627160-10299-1-git-send-email-aleksey.makarov@linaro.org>
References: <2019009.4Y5n3ZF6bK@vostro.rjw.lan>
 <1455627160-10299-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <2136886.lSJtFgotV7@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 16, 2016 03:52:38 PM Aleksey Makarov wrote:
> Factor out the code that finds the first physical device
> of a given ACPI device.  It is used in several places.
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

OK, I've queued up this one and the [2/2] for v4.6.

Thanks,
Rafael
