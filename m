From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Aug 2012 14:46:23 +0000
Subject: [PATCH V4 2/5] clk: mmp: add clock definition for pxa168
In-Reply-To: <CADApbejwG5F5pEicWSAb0308npupfHkE0fqTweec9ve2ZzkREw@mail.gmail.com>
References: <1345183330-20244-1-git-send-email-xiechao.mail@gmail.com>
 <201208171134.32195.arnd@arndb.de>
 <CADApbejwG5F5pEicWSAb0308npupfHkE0fqTweec9ve2ZzkREw@mail.gmail.com>
Message-ID: <201208171446.23851.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 August 2012, Chao Xie wrote:
> The clock tree is formatted into a table, and i used perl to generate
> the code based on the table. In order to make the indent clearly, i
> used the scripts/Lindent to automatically format the .c file.
> I have tried to searched the parameter for indent, but i do not find
> that anything can remove the the style of newline after "=", so in
> order to not format the file line by line, i just accept the results
> of indent.
> Do you have any idea about it?

No easy solution. I don't normally trust lindent. Especially if you want
to bend the rules slightly, it's often better to manually edit the
output of lindent.

	Arnd
