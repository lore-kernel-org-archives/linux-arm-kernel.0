From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Jun 2015 17:57:53 +0200
Subject: [GIT PULL 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <CAOMZO5B_74HgFZqiRWrJXs6BSStfJHB6wicjdUQ4MTAk=SvG=Q@mail.gmail.com>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
 <20150602033337.GA7571@dragon>
 <CAOMZO5B_74HgFZqiRWrJXs6BSStfJHB6wicjdUQ4MTAk=SvG=Q@mail.gmail.com>
Message-ID: <201506021757.54099.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 June 2015, Fabio Estevam wrote:
> Spam Status: Spamassassin 0% probability of being spam.
> 
> Full report:
> No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED, DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,UNPARSEABLE_RELAY autolearn=unavailable version=3.3.1  
> On Tue, Jun 2, 2015 at 12:33 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > So here is my changes to fix all the errors reported by Stephen, except
> > 'SZ_4K' one.  Let me know if it's preferred or we'd like to drop
> > COMPILE_TEST and simply depend on ARCH_MXC.
> 
> I would say that we could drop COMPILE_TEST and use 'depends on
> ARCH_MXC' instead.

Including COMPILE_TEST is generally a good idea, because it enables automatic
checking by build bots, e.g. the coverity bot that runs x86-64 allmodconfig.

	Arnd
