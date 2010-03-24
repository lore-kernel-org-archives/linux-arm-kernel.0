From: andy@warmcat.com (Andy Green)
Date: Wed, 24 Mar 2010 10:57:44 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <20100324102144.GA21935@rakim.wolfsonmicro.main>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<20100324102144.GA21935@rakim.wolfsonmicro.main>
Message-ID: <4BA9F028.2020208@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/10 10:21, Somebody in the thread at some point said:

> The solution above is the other way around - it ensures that the
> regulators come up first - but achieves the same effect.  Unfortunately
> it's not as generic as would be best but it resolves the issues.

How does it "resolve the issue" of uncontrolled race during suspend and 
resume?

-Andy
