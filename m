From: msalter@redhat.com (Mark Salter)
Date: Thu, 01 Sep 2011 15:15:38 -0400
Subject: [PATCH 09/24] C6X: signal management
In-Reply-To: <1314870603.8038.27.camel@mfleming-mobl1.ger.corp.intel.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
	<1314826019-22330-10-git-send-email-msalter@redhat.com>
	<1314870603.8038.27.camel@mfleming-mobl1.ger.corp.intel.com>
Message-ID: <1314904539.1439.25.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-01 at 10:50 +0100, Matt Fleming wrote:
> > +segv_and_exit:
> > +     force_sig(SIGSEGV, current);
> > +     return -EFAULT;
> > +}
> 
> Shouldn't that really be a call to force_sigsegv(signr, current) ?

Yes, I think so. Thanks.

--Mark
