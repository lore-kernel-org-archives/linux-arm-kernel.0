From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2009 08:54:17 +0000
Subject: [patch] spitz: better voltage-to-percentage conversion
In-Reply-To: <20091127073119.GB1405@ucw.cz>
References: <20091127073119.GB1405@ucw.cz>
Message-ID: <20091127085417.GB27009@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 08:31:19AM +0100, Pavel Machek wrote:
> +
> +typedef int miliamp_t;
> +typedef int miliohm_t;
> +typedef int milivolt_t;

'milliamp' 'milliohm' 'millivolt'
