From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Nov 2014 10:47:05 +0100
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <545C69E7.6010909@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
 <545C694D.1030204@gmail.com> <545C69E7.6010909@gmail.com>
Message-ID: <2747100.M77UGx4AmB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 22:42:47 Frank Rowand wrote:
> This same change is also needed in:
> 
>   qcom-ipq8064.dtsi
>   qcom-msm8960.dtsi
>   qcom-apq8084.dtsi
>   qcom-apq8064.dtsi
>   qcom-msm8660.dtsi
> 
> but I did not want to just blindly apply those changes without testing.
> 

Is there only one uart on each of these?

If not, it would be better to put the aliases in the board specific file,
pointing to whichever ports are in use, in the order that makes sense
for that board.

	Arnd
