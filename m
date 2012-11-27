From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 Nov 2012 17:12:50 +0100
Subject: [PATCH 4/6 v5] arm highbank: add support for pl320 IPC
In-Reply-To: <1354028674-23685-5-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354028674-23685-5-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <20121127171250.3984e990@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Langsdorf,

On Tue, 27 Nov 2012 09:04:32 -0600, Mark Langsdorf wrote:

> +int ipc_transmit(u32 *data);

ipc_transmit() looks to me like a way to generic name to be exposed to
the entire kernel.

> +extern int pl320_ipc_register_notifier(struct notifier_block *nb);
> +extern int pl320_ipc_unregister_notifier(struct notifier_block *nb);

Why some "extern" here? You don't have these for the other functions in
this header file.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
