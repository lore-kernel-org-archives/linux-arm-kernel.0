From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 2 Jun 2013 22:42:42 +0200
Subject: [PATCH 07/15] cpufreq: spear needs cpufreq table
In-Reply-To: <CALF0-+XYhpLaJLSZqamuV0aQFwxtu4WS7RNpbU6Li78gmMSOWw@mail.gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-8-git-send-email-arnd@arndb.de>
 <CALF0-+XYhpLaJLSZqamuV0aQFwxtu4WS7RNpbU6Li78gmMSOWw@mail.gmail.com>
Message-ID: <20130602204242.GA10843@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 11:17:48PM -0300, Ezequiel Garcia wrote:
> On Fri, May 31, 2013 at 7:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Like a lot of the other cpufreq drivers, this one needs to
> > select CONFIG_CPU_FREQ_TABLE to avoid a build error like
> >
> 
> Indeed. I found the same thing while playing with Kirkwood's.
> 
> @Andrew, I have a patch sitting here, but feel free to send it if you want.

Hi Ezequiel

Please send your patch.

Thanks
       Andrew
