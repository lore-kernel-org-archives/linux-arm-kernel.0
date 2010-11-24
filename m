From: me@felipebalbi.com (Felipe Balbi)
Date: Wed, 24 Nov 2010 22:48:40 +0200
Subject: [PATCH] OMAP: UART: don't resume UARTs that are not enabled.
In-Reply-To: <1290625743-8370-1-git-send-email-khilman@deeprootsystems.com>
References: <1290625743-8370-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1290631720.15533.30.camel@eowin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2010-11-24 at 11:09 -0800, Kevin Hilman wrote:
> Add additional check to omap_uart_resume_idle() so that only
> enabled (specfically, idle-enabled) UARTs are allowed to resume.

typo: specifically

-- 
balbi
