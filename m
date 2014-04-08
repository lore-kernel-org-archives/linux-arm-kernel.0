From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 09 Apr 2014 01:05:54 +0400
Subject: The Alphabet (or, the sorting of Kconfig symbols)
In-Reply-To: <20140408202137.GC30453@netboy>
References: <20140404111647.GZ7528@n2100.arm.linux.org.uk>
 <CACxGe6uoB6CkuV7HCg8wdyu2Tm471YaAz0sDA3W2C0MPAYYY+Q@mail.gmail.com>
 <20140408185225.GU29751@pengutronix.de> <20140408202137.GC30453@netboy>
Message-ID: <534464B2.4020004@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/09/2014 12:21 AM, Richard Cochran wrote:

>> With #includes there might be exceptions though because of dependencies
>> between headers.

> That is surely a sign of broken code.

    Yeah, such dependencies should normally be resolved in the headers 
themselves, not the including code. Even the USB maintainer have finally 
agreed with that. :-)

WBR, Sergei
