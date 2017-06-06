From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 6 Jun 2017 12:03:51 +0000
Subject: [PATCH 01/10] staging: fsl-mc: enclose macro params in parens
In-Reply-To: <20170603084126.GB10784@kroah.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
 <20170531105852.22304-2-laurentiu.tudor@nxp.com>
 <20170603084126.GB10784@kroah.com>
Message-ID: <VI1PR0401MB185672AD42A817013EB27CAFECCB0@VI1PR0401MB1856.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: Saturday, June 03, 2017 11:41 AM
> 
> On Wed, May 31, 2017 at 01:58:43PM +0300, laurentiu.tudor at nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > Several macros didn't had macro params enclosed in parens. Fix them to
> > avoid precedence issues.
> >
> > Found with checkpatch.pl who was issuing this
> > message:
> >   "Macro argument 'id' may be better as '(id)'
> >    to avoid precedence issues"
> 
> Why are you line-wrapping at such a small number?  Please use 72 columns like
> git asks you to...

I'll rewrap the commit message in the next spin.

---
Thanks & Best Regards, Laurentiu
