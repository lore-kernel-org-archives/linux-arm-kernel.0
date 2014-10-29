From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Wed, 29 Oct 2014 11:10:08 +0800
Subject: [PATCH] 6fire: Convert byte_rev_table uses to bitrev8
In-Reply-To: <1414551974.10912.16.camel@perches.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
 <1414531369.10912.14.camel@perches.com>
 <35FD53F367049845BC99AC72306C23D103E010D1825C@CNBJMBX05.corpusers.net>
 <1414551974.10912.16.camel@perches.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D1825E@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Joe Perches [mailto:joe at perches.com]
> > I think the most safe way is change byte_rev_table[] to be satic, So
> > that no driver can access it directly, The build error can remind the
> > developer if they use byte_rev_table[] Directly .
> 
> You can do that with your later patch, but the existing uses _must_ be
> converted first so you don't break the build.
> 
> 
Yeah, I agree with you,
I will add this into my later patch.

Thanks
