From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 1 Dec 2010 19:30:54 +0800
Subject: [PATCH] add clock debug information for imx51 babbage
Message-ID: <AANLkTi=cTYjaDh0Zd-7joLCycMcLoPW+Ekws=46QMoDc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

This patch makes BSP development easier, since it displays the whole
clock information in tree-like manner. The final goal is to make it a
part of common clock framework, but so far this goal depends on other
unfinished work.

PS: Due to the firewall problem, I send out patch this way. Please
give comments inline and use attached patch for testing.
