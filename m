From: davem@davemloft.net (David Miller)
Date: Thu, 06 Feb 2014 19:53:42 -0800 (PST)
Subject: [PATCH v1 1/3] net: stmmac:sti: Add STi SOC glue driver.
In-Reply-To: <1391428868-27245-1-git-send-email-srinivas.kandagatla@st.com>
References: <1391428787-27143-1-git-send-email-srinivas.kandagatla@st.com>
 <1391428868-27245-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20140206.195342.1998479313077409827.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <srinivas.kandagatla@st.com>
Date: Mon, 3 Feb 2014 12:01:08 +0000

> +	res = platform_get_resource_byname(pdev,
> +				IORESOURCE_MEM, "sti-ethconf");

This is not the correct way to format multi-line function calls,
you'll need to fix this up in this entire series.

The arguments on the second and subsequent lines must start at
the first column after the openning parenthesis of the function
call.  You must use the appropriate number of both space and
TAB characters necessary to do so.

If you're only using TAB characters to indent, you're doing it
wrong.

Thank you.
