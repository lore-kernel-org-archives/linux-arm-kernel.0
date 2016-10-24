From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 25 Oct 2016 00:30:18 +0200
Subject: [PATCH v4 0/9] PM / Domains: DT support for domain idle states &
 atomic PM domains
In-Reply-To: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <2068597.AeryDFjO6y@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 24, 2016 03:20:59 PM Lina Iyer wrote:
> Hi all,
> 
> Changes since v3 [5] -
> - Added "domain-idle-state" compatible to arm/idle-states.txt
> - Updated documentation for defining PM domain idle states
> - Updated documentation for devices and PM domains.
> - Updated code to look for "domain-idle-state" instead of "arm,idle-state" compatible.
> - The series is available at [6].

Is this the series I've already queued up?

If so, can you please send a delta patch only with a proper changelog?

Thanks,
Rafael
