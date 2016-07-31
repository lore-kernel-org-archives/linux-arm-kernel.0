From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 31 Jul 2016 12:52:55 +0300
Subject: [PATCH] net: thunderx: correct bound check in nic_config_loopback
In-Reply-To: <1469933384-16827-1-git-send-email-alexander.levin@verizon.com>
References: <1469933384-16827-1-git-send-email-alexander.levin@verizon.com>
Message-ID: <8826fedc-8419-19a9-28d0-faf46ccc9f9f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/31/2016 5:49 AM, Levin, Alexander wrote:

> Off by one in nic_config_loopback would access an invalid arrat variable when

    Array?

> vf id == MAX_LMAC.
>
> Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
[...]

MBR, Sergei
