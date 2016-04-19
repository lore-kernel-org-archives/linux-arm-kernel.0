From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Apr 2016 09:53:01 -0600
Subject: [PATCH 0/8] STMPE fixes/rework and add STMPE1600 support
In-Reply-To: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
Message-ID: <5716545D.9080006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2016 06:18 AM, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> This series cleans and fixes some bugs in MFD/GPIO STMPE drivers and prepare
>   the ground to add new STMPE1600 support.
>
> STMPE1600 datasheet is available here :
> http://www2.st.com/content/st_com/en/products/interfaces-and-transceivers/
> i-o-expanders-and-level-translators/i-o-expanders/stmpe1600.html
>
> Only STMPE1600 has been tested on STM32 platform. As i have no board with
> others STMPE variant(STMPE610/STMPE801/STMPE811/STMPE1601/STMPE1801/STMPE2401
> and STMPE2403), i put in CC boards's maintainers which are using others STMPE variant.
>
> If they can kindly check that no regression has been introduce by this series

> For TEGRA ARCHITECTURE SUPPORT
> 	_ Stephen Warren <swarren@wwwdotorg.org>
> 	_ Thierry Reding <thierry.reding@gmail.com>
> 	_ Alexandre Courbot <gnurou@gmail.com>

I don't know what STMPE is, and I don't believe it is used on Tegra; 
what makes you think it is?
