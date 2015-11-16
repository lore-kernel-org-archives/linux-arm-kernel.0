From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Nov 2015 15:45:17 +0100
Subject: [PATCH v4 00/24] pwm: add support for atomic update
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <3500453.9dNCEh5KzI@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Am Montag, 16. November 2015, 09:56:23 schrieb Boris Brezillon:
> Hello,
> 
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

you already include my tested-by tags, but anyway, the series still works 
nicely on 4.4-rc1 on my veyron chromebook.


Heiko
