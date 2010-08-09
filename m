From: justinmattock@gmail.com (Justin P. Mattock)
Date: Mon, 09 Aug 2010 14:56:40 -0700
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <1281389338.7143.32.camel@localhost>
References: <4C5F9B25.8080401@st.com>	
	<201008091735.11105.mihai.dontu@gmail.com>
	<4C6040FC.2020702@gmail.com>	
	<201008092115.25992.mihai.dontu@gmail.com>
	<1281389338.7143.32.camel@localhost>
Message-ID: <4C607998.90509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2010 02:28 PM, David Woodhouse wrote:
> On Mon, 2010-08-09 at 21:15 +0300, Mihai Don?u wrote:
>>
>> Wait. I don't think we're on the same page here. I'm talking about message
>> signing (which does not require the receiving end to have any key - it's the
>> same plain text e-mail with a blob after it) while you refer to actually
>> encrypting the message. Mm? Or am I being extremely slow today? :-)
>
> Only when you assume that Exchange would pass signed messages without
> corrupting them. It really is that broken.
>

figured the encryption would be kind of a last resort situation..but if 
it's that broken to where it wont pass it along without corrupting, then 
the best solution is to figure out what Microsoft needs in terms of 
encoding, i.e. is there a way to have the scanner scan but not throw 
everything around after it scans.(if this is what it's doing)

Justin P. Mattock
