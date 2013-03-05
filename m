From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 5 Mar 2013 07:03:51 +0000
Subject: [PATCH LINUX v5] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <513596F2.1000701@gmail.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
 <51340ACD.70904@gmail.com>
 <20130305030436.GA18040@mudshark.cambridge.arm.com>
 <513596F2.1000701@gmail.com>
Message-ID: <1362467031.8941.51.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-05 at 06:55 +0000, Rob Herring wrote:
> Here's a config:

Was it truncated? oldconfig is asking a ton of questions, far more than
I would expect for something like variance between our HEADs etc.

If I just answer the default to all the questions then I get a .config
with Xen on etc, but I still don't see the issue.

Ian.
