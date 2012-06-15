From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 09:01:17 -0300
Subject: [PATCH v2 2/3] serial: mxs-auart: Allow device tree probing
In-Reply-To: <201206151349.27261.marex@denx.de>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
 <1339759950-5507-2-git-send-email-festevam@gmail.com>
 <201206151349.27261.marex@denx.de>
Message-ID: <CAOMZO5CWtJO6Ka0sM+ZNrK+dTLDQ9eXFj-XvFXdkZND1_F40NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Jun 15, 2012 at 8:49 AM, Marek Vasut <marex@denx.de> wrote:

>> +#ifdef CONFIG_OF
>
> Isn't CONFIG_OF always enabled?

Not always necessarily. You can boot mx23/mx28 via non-DT kernel.

The serial imx driver also does the same thing about this.
