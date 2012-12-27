From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 27 Dec 2012 14:12:58 +0100
Subject: [PATCH 0/6 v8] cpufreq: add support for Calxeda ECX-1000
 (highbank)
In-Reply-To: <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <2705062.NIaFfcLb3a@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 05, 2012 10:48:35 AM Mark Langsdorf wrote:
> This patch series adds cpufreq support for the Calxeda
> ECX-1000 (highbank) SoCs. The EnergyCore Management Engine (ECME) on
> the ECX-1000 manages the voltage for the part and communications with
> Linux through a pl320 mailbox. clk notifications are used to control
> when to send messages to the ECME.

If you want me to handle this, can you please resend the whole patchset (with
all of the comments addressed, if possible)?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
