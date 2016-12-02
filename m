From: joseph@codesourcery.com (Joseph Myers)
Date: Fri, 2 Dec 2016 21:56:49 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core
 support
In-Reply-To: <20161202182126.GS1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
 <20161202114850.GQ1574@e103592.cambridge.arm.com>
 <faabab1d-fafb-2bd1-200f-b0e3ba17e1d5@redhat.com>
 <alpine.DEB.2.20.1612021648580.16956@digraph.polyomino.org.uk>
 <20161202182126.GS1574@e103592.cambridge.arm.com>
Message-ID: <alpine.DEB.2.20.1612022154530.1078@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Dec 2016, Dave Martin wrote:

> Presumably the C language specs specify that fenv manipulations cannot
> be reordered with respect to evaluation or floating-point expressions?

Yes (in the context of #pragma STDC FENV_ACCESS ON).  And you need to 
presume that an arbitrary function call might manipulate the environment 
unless you know it doesn't.

-- 
Joseph S. Myers
joseph at codesourcery.com
