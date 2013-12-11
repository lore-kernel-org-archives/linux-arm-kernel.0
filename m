From: robherring2@gmail.com (Rob Herring)
Date: Tue, 10 Dec 2013 20:06:08 -0600
Subject: [Linaro-acpi] [PATCH v3 1/5] ACPI: introduce
 CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
In-Reply-To: <20131210224912.996FCC40CE1@trevor.secretlab.ca>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
 <52A72D9F.1070004@linaro.org>
 <20131210224912.996FCC40CE1@trevor.secretlab.ca>
Message-ID: <CAL_JsqK1EJbNud2Pxojso=Vjo9ePEuwi3OUcwoCiwCpKH24LgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 4:49 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Hi Hanjun,
>
> Okay, so after talking with Al and Graeme on IRC, I think I understand
> what is going on. The fact that ACPICA doesn't allow for both normal and
> hardware reduced support in the same build is a very big problem.
> However, it isn't a problem for ARM since we'll never support
> non-hardware reduced mode. The x86 folks need to work that out when/if
> they ever add support for hardware reduced mode.

I believe SMBIOS/DMI tables are only part of full ACPI, so there is a
need on ARM for more than hardware reduced mode.

Rob
