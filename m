From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 28 Jul 2011 14:17:33 +0800
Subject: [PATCH v4 2/2] ARM: l2x0: Add OF based initialization
In-Reply-To: <1309984979-8847-2-git-send-email-robherring2@gmail.com>
References: <1309984979-8847-1-git-send-email-robherring2@gmail.com>
	<1309984979-8847-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAGsJ_4zXY4HVF6=e4w0ja90HrQzwaaokoSM6tEt06amFMZYMHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/7 Rob Herring <robherring2@gmail.com>:
> From: Rob Herring <rob.herring@calxeda.com>
>
> This adds probing for ARM L2x0 cache controllers via device tree. Support
> includes the L210, L220, and PL310 controllers. The binding allows setting
> up cache RAM latencies and filter addresses (PL310 only).
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Barry Song <21cnbao@gmail.com>

-barry
