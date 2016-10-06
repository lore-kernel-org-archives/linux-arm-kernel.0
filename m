From: ken.lin@advantech.com (Ken.Lin)
Date: Thu, 6 Oct 2016 16:26:32 -0700
Subject: The possible regression in kernel 4.8 - clk: imx: correct AV
 PLL rate formula
References: <03B5A3CA1724CE4EAC32B27E39292A677FC5A390AF@AUSMAIL1.AUS.ADVANTECH.CORP>
Message-ID: <WM!ed3fbaeb0522ef511432f86a8f960e4450d5dc585c3e6a7282707c963f20491527420d38f737d38adb9ab7cba9794282!@dg.advantech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Ken.Lin 
Sent: Thursday, October 6, 2016 4:21 PM
To: 'shawnguo at kernel.org'; 'kernel at pengutronix.de'; 'sboyd at codeaurora.org'; 'mturquette at baylibre.com'
Cc: 'linux-arm-kernel at lists.infradead.org'; 'linux-clk at vger.kernel.org'; 'linux-kernel at vger.kernel.org'; Peter.Stretz; Peter.Chiang; Akshay Bhat
Subject: The possible regression in kernel 4.8 - clk: imx: correct AV PLL rate formula

Hi,

We found a possible regression issue (not seen in kernel 4.7-stable), which has to do with the new NXP commit ba7f4f557eb67ee21c979c8539dc1886f5d5341c when we did a DP test (1920x1080 at 60) with clock source PLL5.
The DP desired pixel clock (148.5MHz that is calculated from the input of PLL output frequency) would be correct again when we reverted this commit.
Could you please help check if the commit has the side effect since it would have impacts on our on-going project when it requires moving from kernel 4.7 to kernel 4.8 or newer version?

Please check the following URL for the details
https://www.dropbox.com/s/7wc5jdp8unlsiob/possible_regression_for_clk_imx_correct_VL_PLL_rate_formula.pdf?dl=0


Thank you

Cheers,
Ken Lin

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
