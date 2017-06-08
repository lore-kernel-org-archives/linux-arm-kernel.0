From: angus@akkea.ca (Angus Ainslie)
Date: Thu, 08 Jun 2017 07:13:56 -0600
Subject: Staging r8723bs driver for kernel 4.12.0-rc2 on CHIPPro
In-Reply-To: <20170608123844.igx7dofpakpcqg4o@flea.home>
References: <bcc1a7c44ba34cb077a1df09971d6926@www.akkea.ca>
 <8485e88721d4761d5b1a10ff1eebfd36@www.akkea.ca>
 <1496925243.11482.19.camel@hadess.net>
 <20170608123844.igx7dofpakpcqg4o@flea.home>
Message-ID: <32a79e1299eecf52c454cf3e80e903ac@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-08 06:38, Maxime Ripard wrote:
> 
> This is for the old NTC's 4.4 kernel though. I think Angus is talking
> about a mainline 4.12.
> 

Yeah I'm working with the 4.12 kernel . I would have just stuck with the 
4.4 but I wasn't able to get suspend working on 4.4 . 4.12 suspend looks 
to be working so I started forward on that.

I did also try the out of tree driver thinking that maybe to much stuff 
got stripped out when it went into staging. The fails in exactly the 
same way that the staging driver does so it some kernel change that must 
be cause the failure to load.
