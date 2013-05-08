From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 08 May 2013 19:18:02 +0100
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <20130508143908.GJ24282@game.jcrosoft.org>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de> <20130508143908.GJ24282@game.jcrosoft.org>
Message-ID: <518A96DA.5060809@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/13 15:39, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> +
>> > 
>> > Please remove all forward declarations, by reordering the functions in
>> > the way they are called.
>> > 
> and drop the dummy functions
We can not remove the dummy functions, as the serial-core does not check
it before using them.
>> > 
>>> > > diff --git a/drivers/tty/serial/st-asc.h b/drivers/tty/serial/st-asc.h
>>> > > new file mode 100644
>>> > > index 0000000..e59f818
>>> > > --- /dev/null
>>> > > +++ b/drivers/tty/serial/st-asc.h
