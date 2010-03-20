From: mogambo.kztrj@gmail.com (Mogambo Park)
Date: Sat, 20 Mar 2010 18:22:43 +0900
Subject: Using of cached values
Message-ID: <2703439e1003200222y16147d81x27b0a8bcc804c338@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

good morning

  I wants to know - How safe to read register values one time in a structure
and use value from there, assume no write is performed on the
register? I see many
files in sound/soc/codec/ do that.

is it becos sometime the register may return not accurate value on
busy bus by h/w mistake?
OR I should always read from register even if his value is not
expected to change?

lot thanks
