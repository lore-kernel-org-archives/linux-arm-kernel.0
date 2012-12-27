From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Thu, 27 Dec 2012 08:28:22 -0500
Subject: [PATCH 0/6 v8] cpufreq: add support for Calxeda ECX-1000
 (highbank)
In-Reply-To: <2705062.NIaFfcLb3a@vostro.rjw.lan>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>,
 <2705062.NIaFfcLb3a@vostro.rjw.lan>
Message-ID: <21672683C5A3814BB4DB938EBE482DE435D97660AB@IAD2MBX09.mex02.mlsrvr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I thought I had addressed all the issues with the v9 version. The only comments I got on it was Mike's reviewed-by and I didn't think that warranted a resend.

If you do want me to send it again, do you want it  updated to current top-of-tree? That may take a bit, since there's an unrelated bug that's preventing my test box from booting.

--Mark Langsdorf
Calxeda, Inc.


________________________________________
From: Rafael J. Wysocki [rjw at sisk.pl]
Sent: Thursday, December 27, 2012 7:12 AM
To: Mark Langsdorf
Cc: linux-kernel at vger.kernel.org; cpufreq at vger.kernel.org; linux-pm at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 0/6 v8] cpufreq: add support for Calxeda ECX-1000 (highbank)

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
