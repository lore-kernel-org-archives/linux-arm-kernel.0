From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Oct 2014 11:30:31 +0000
Subject: [PATCH] ARM: l2c: Improve l2c310_of_parse() error message
In-Reply-To: <1414582112-4745-1-git-send-email-festevam@gmail.com>
References: <1414582112-4745-1-git-send-email-festevam@gmail.com>
Message-ID: <20141029113031.GL27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 09:28:32AM -0200, Fabio Estevam wrote:
> -		pr_err("PL310 OF: cache setting yield illegal associativity\n");
> -		pr_err("PL310 OF: %d calculated, only 8 and 16 legal\n", assoc);
> +		pr_err("L2C-310 OF cache associativity %d invalid, only 8 or 16 permitted\n", assoc);

Almost, but that'll upset the checkpatch brigade.  Best move the " assoc);"
onto the next line. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
