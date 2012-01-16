From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 16 Jan 2012 14:47:43 +0400
Subject: [PATCH 5/8] dmaengine/dw_dmac: Use platform_get_drvdata instead
 of accessing dev directly
In-Reply-To: <51d3263224d48c1d68de1449af28fb1570900254.1326707233.git.viresh.kumar@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <51d3263224d48c1d68de1449af28fb1570900254.1326707233.git.viresh.kumar@st.com>
Message-ID: <4F14004F.2010906@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 16-01-2012 13:50, Viresh Kumar wrote:

> Use already defined function platform_get_drvdata() instead of accessing
> pdev->dev.data.

    pdev->dev.platform_data.

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>

WBR, Sergei
