From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sat, 25 Nov 2017 10:59:45 +0200
Subject: [PATCH 2/6] clk: lpc32xx: pr_err() strings should end with
 newlines
In-Reply-To: <1dddfd71153339875c7bedf6e562483607180a4d.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
 <1dddfd71153339875c7bedf6e562483607180a4d.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <9a9fda0f-6da5-a6c3-439a-01db44f171b9@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arvind,

thank you for the change.

On 11/24/2017 08:55 AM, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
