From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 9 Apr 2015 10:43:10 +0100
Subject: [PATCH] ata: ahci_st: fixup layering violations / drvdata errors
In-Reply-To: <552627BD.9060109@st.com>
References: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
 <552627BD.9060109@st.com>
Message-ID: <20150409094310.GA29026@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, 09 Apr 2015, Maxime Coquelin wrote:
> Hello Brian,
> 
<snip>
> >  drivers/ata/ahci_st.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> >
> 
> Your patch looks sensible, thanks for spotting this issue.
> 
> Peter, do you have the SATA setup in place to test Brian's patch?

Yes I can test, although not until Saturday as I only have remote
access to the board today & tomorrow and the hard drive isn't
plugged in.

regards,

Peter.
